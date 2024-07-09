package org.variantsync.diffdetectivedemo;

import org.eclipse.jgit.diff.DiffAlgorithm;
import org.variantsync.diffdetective.diff.result.DiffParseException;
import org.variantsync.diffdetective.show.Show;
import org.variantsync.diffdetective.show.engine.GameEngine;
import org.variantsync.diffdetective.variation.DiffLinesLabel;
import org.variantsync.diffdetective.variation.diff.VariationDiff;
import org.variantsync.diffdetective.variation.diff.parse.VariationDiffParseOptions;
import org.variantsync.diffdetective.variation.tree.VariationTree;
import org.variantsync.truediffdetective.TrueDiffDetective;

import java.io.IOException;
import java.nio.file.Path;

/**
 * DiffDetective Demo for FSE 2024.
 *
 */
public class Main
{
    public static void main(String[] args) throws IOException, DiffParseException {
        Path examplesDir = Path.of("data", "examples");
        Path pathBefore  = examplesDir.resolve("simple_v1.txt");
        Path pathAfter   = examplesDir.resolve("simple_v2.txt");

        VariationTree<DiffLinesLabel> s1 = VariationTree.fromFile(pathBefore);
        VariationTree<DiffLinesLabel> s2 = VariationTree.fromFile(pathAfter);

        VariationDiff<DiffLinesLabel> diffViaGumTree
                = VariationDiff.fromTrees(s1, s2);
        VariationDiff<DiffLinesLabel> diffViaGit
                = VariationDiff.fromFiles(pathBefore, pathAfter,
                                          DiffAlgorithm.SupportedAlgorithm.MYERS,
                                          VariationDiffParseOptions.Default);
        VariationDiff<DiffLinesLabel> diffViaTrueDiff
                = TrueDiffDetective.compare(s1, s2);

        GameEngine.showAndAwaitAll(
                Show.tree(s1, "before"),
                Show.tree(s2, "after"),
                Show.diff(diffViaGit, "diffViaGit"),
                Show.diff(diffViaTrueDiff, "diffViaTrueDiff"),
                Show.diff(diffViaGumTree, "diffViaGumTree")
        );
    }
}
