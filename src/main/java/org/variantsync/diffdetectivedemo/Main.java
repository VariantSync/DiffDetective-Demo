package org.variantsync.diffdetectivedemo;

import org.eclipse.jgit.diff.DiffAlgorithm;
import org.variantsync.diffdetective.AnalysisRunner;
import org.variantsync.diffdetective.analysis.Analysis;
import org.variantsync.diffdetective.diff.result.DiffParseException;
import org.variantsync.diffdetective.show.Show;
import org.variantsync.diffdetective.show.engine.GameEngine;
import org.variantsync.diffdetective.variation.DiffLinesLabel;
import org.variantsync.diffdetective.variation.diff.VariationDiff;
import org.variantsync.diffdetective.variation.diff.construction.JGitDiff;
import org.variantsync.diffdetective.variation.diff.parse.VariationDiffParseOptions;
import org.variantsync.diffdetective.variation.diff.view.DiffView;
import org.variantsync.diffdetective.variation.tree.VariationTree;
import org.variantsync.diffdetective.variation.tree.view.relevance.Configure;
import org.variantsync.diffdetective.variation.tree.view.relevance.Trace;

import java.io.IOException;
import java.nio.file.Path;

import static org.variantsync.diffdetective.util.fide.FixTrueFalse.Formula.*;

/**
 * DiffDetective Demo for FSE 2024.
 *
 */
public class Main
{
    /**
     * Given two names of text files, which are located in the "data/examples/" directory, as input,
     * this method will
     * - parse them to variation trees,
     * - diff those trees using GumTree to get a variation diff,
     * - diff the text files using JGit and then parse a variation diff,
     * - and finally show all trees and diffs in a GUI.
     */
    private static void inspect(String fileBefore, String fileAfter) throws IOException, DiffParseException {
        final Path examplesDir = Path.of("data", "examples");
        final Path pathBefore  = examplesDir.resolve(fileBefore);
        final Path pathAfter   = examplesDir.resolve(fileAfter);
        
        String textDiff = JGitDiff.textDiff(pathBefore, pathAfter, DiffAlgorithm.SupportedAlgorithm.MYERS);
        System.out.println(textDiff);
        
        VariationTree<DiffLinesLabel> s1 = VariationTree.fromFile(pathBefore);
        VariationTree<DiffLinesLabel> s2 = VariationTree.fromFile(pathAfter);
        
        VariationDiff<DiffLinesLabel> diffViaGumTree = VariationDiff.fromTrees(s1, s2);
        VariationDiff<DiffLinesLabel> diffViaGit     = VariationDiff.fromFiles(pathBefore, pathAfter, DiffAlgorithm.SupportedAlgorithm.MYERS, VariationDiffParseOptions.Default);

        GameEngine.showAndAwaitAll(
                Show.tree(s1),
                Show.tree(s2),
                Show.diff(diffViaGumTree),
                Show.diff(diffViaGit)
        );
        
        // Views: Trace
        GameEngine.showAndAwaitAll(
                Show.diff(diffViaGit),
                Show.diff(DiffView.optimized(diffViaGit, new Trace("B"))) // C
        );
        
        // Views: Partial Configuration
        GameEngine.showAndAwaitAll(
                Show.diff(diffViaGit),
                Show.diff(DiffView.optimized(diffViaGit, new Configure(not(var("A"))))) // C
        );
    }
    
    public static void main(String[] args) throws IOException, DiffParseException {
        inspect("simple_v1.txt", "simple_v2.txt");
//        inspect("vim_evalfunc_v1.txt", "vim_evalfunc_v2.txt");
//        runSomeHistoryAnalysis();
    }
    
    public static void runSomeHistoryAnalysis() throws IOException {
        AnalysisRunner.run(
                new AnalysisRunner.Options(
                        Path.of("data", "repos"), 
                        Path.of("data", "output"),
                        Path.of("data", "demo-dataset.md")
                ),
                (repository, path) -> Analysis.forEachCommit(() -> DemoAnalysis.Create(repository, path), 20, 8)                
        );
    }
}
