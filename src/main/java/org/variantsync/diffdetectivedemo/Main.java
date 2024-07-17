package org.variantsync.diffdetectivedemo;

import org.eclipse.jgit.diff.DiffAlgorithm;
import org.variantsync.diffdetective.AnalysisRunner;
import org.variantsync.diffdetective.analysis.Analysis;
import org.variantsync.diffdetective.diff.result.DiffParseException;
import org.variantsync.diffdetective.show.Show;
import org.variantsync.diffdetective.show.engine.GameEngine;
import org.variantsync.diffdetective.variation.DiffLinesLabel;
import org.variantsync.diffdetective.variation.Label;
import org.variantsync.diffdetective.variation.diff.VariationDiff;
import org.variantsync.diffdetective.variation.diff.parse.VariationDiffParseOptions;
import org.variantsync.diffdetective.variation.tree.VariationTree;
import org.variantsync.truediffdetective.TrueDiffDetective;

import java.io.IOException;
import java.nio.file.Path;

/**
 * DiffDetective Demo for FSE 2024.
 */
public class Main
{

    public static void showDiff(
            Path fileBefore,
            Path fileAfter)
            throws IOException, DiffParseException
    {
        VariationDiff<DiffLinesLabel> d = VariationDiff.fromFiles(
                fileBefore,
                fileAfter,
                DiffAlgorithm.SupportedAlgorithm.MYERS,
                VariationDiffParseOptions.Default);
        Show.diff(d, "Diff via Git Diff").showAndAwait();
    }


    public static <L extends Label> void showDiff(
            VariationTree<L> before,
            VariationTree<L> after)
    {
        VariationDiff<L> diffViaGumTree = VariationDiff.fromTrees(before, after);
        Show.diff(diffViaGumTree, "Diff via GumTree").showAndAwait();
    }


    public static void main(String[] args) throws IOException, DiffParseException {
        Path pathBefore  = Path.of("data", "examples", "simple_v1.txt");
        Path pathAfter   = Path.of("data", "examples", "simple_v2.txt");

        showDiff(pathBefore, pathAfter);
        showDiff(VariationTree.fromFile(pathBefore),VariationTree.fromFile(pathAfter));

        /*
        AnalysisRunner.run(
                new AnalysisRunner.Options(
                        Path.of("data", "repos"),
                        Path.of("data", "output"),
                        Path.of("data", "demo-dataset.md")
                ),
                (repository, path) -> Analysis.forEachCommit(() -> DemoAnalysis.Create(repository, path), 20, 8)
        );
        //*/
    }
}
