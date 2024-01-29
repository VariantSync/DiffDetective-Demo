package org.variantsync.diffdetectivedemo;

import org.tinylog.Logger;
import org.variantsync.diffdetective.analysis.Analysis;
import org.variantsync.diffdetective.analysis.AnalysisResult;
import org.variantsync.diffdetective.analysis.SimpleMetadata;
import org.variantsync.diffdetective.datasets.Repository;

import java.nio.file.Path;
import java.util.List;

/**
 * A tiny analysis, which
 * - counts the number of processed commits and prints that number to terminal,
 * - counts the number of diffs with at least 100 changed nodes and stores that number as result
 */
public class DemoAnalysis implements Analysis.Hooks {
    private static final AnalysisResult.ResultKey<BigDiffCounter> BIG_DIFF_COUNTER_RESULT_KEY = new AnalysisResult.ResultKey<>("big diffs");
    private static final int IS_BIG_THRESHOLD = 100;
    private int commits = 0;
    
    private static class BigDiffCounter extends SimpleMetadata<Integer, BigDiffCounter> {
        public BigDiffCounter() {
            super(0, "big diffs", Integer::sum);
        }
    }

    @Override
    public void initializeResults(Analysis analysis) {
        analysis.append(BIG_DIFF_COUNTER_RESULT_KEY, new BigDiffCounter());
    }

    @Override
    public boolean beginCommit(Analysis analysis) throws Exception {
        ++commits;
        return true;
    }

    @Override
    public boolean analyzeVariationDiff(Analysis analysis) {
        var diff = analysis.getCurrentVariationDiff();
        
        if (diff.computeAllNodesThat(node -> node.isAdd() || node.isRem()).size() >= IS_BIG_THRESHOLD) {
            analysis.get(BIG_DIFF_COUNTER_RESULT_KEY).value++;
        }
        
        return true;
    }

    @Override
    public void endBatch(Analysis analysis) throws Exception {
        Logger.info("Batch done: {} commits analyzed", commits);
    }
    
    public static Analysis Create(Repository repo, Path outputDirectory) {
        return new Analysis(
                "my analysis",
                List.of(
                        new DemoAnalysis()
//                        , new StatisticsAnalysis()
//                        , new EditClassValidation()
                ),
                repo,
                outputDirectory
        );
    }
}
