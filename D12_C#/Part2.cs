using System.Collections.Generic;

namespace D12 {
    /// <summary>
    /// Part 2
    /// </summary>
    public static class Part2 {
        /// <summary>
        /// Part 2
        /// </summary>
        /// <param name="graph">Graph</param>
        /// <returns>Part 2 solution</returns>
        internal static int Run(Graph graph) {
            return Program.CountPaths(graph, true);
        }
    }
}
