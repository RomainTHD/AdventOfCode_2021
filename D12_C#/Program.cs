using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;


namespace D12 {
    /// <summary>
    /// Node
    /// </summary>
    internal class Node {
        /// <summary>
        /// Node data
        /// </summary>
        private readonly string _data;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="data">Data</param>
        public Node(string data) {
            _data = data;
        }

        /// <summary>
        /// Small cave or big cave
        /// </summary>
        /// <returns>Small cave or big cave</returns>
        public bool IsSmallCave() {
            return char.IsLower(_data[0]);
        }

        /// <summary>
        /// To string
        /// </summary>
        /// <returns>String representation</returns>
        public override string ToString() {
            return _data;
        }

        /// <summary>
        /// Hashcode
        /// </summary>
        /// <returns>Hashcode</returns>
        public override int GetHashCode() {
            return _data.GetHashCode();
        }

        /// <summary>
        /// Equals
        /// </summary>
        /// <param name="other">Other</param>
        /// <returns>Equals</returns>
        public bool Equals(string other) {
            return _data.Equals(other);
        }

        /// <summary>
        /// Equals
        /// </summary>
        /// <param name="other">Other</param>
        /// <returns>Equals</returns>
        public override bool Equals(object other) {
            return other != null && _data.Equals(other.ToString());
        }
    }

    /// <summary>
    /// Graph
    /// </summary>
    internal class Graph {
        /// <summary>
        /// Edges
        /// </summary>
        private readonly List<Tuple<Node, Node>> _edges;

        /// <summary>
        /// Start node
        /// </summary>
        public readonly Node Start = new("start");

        /// <summary>
        /// End node
        /// </summary>
        public readonly Node End = new("end");

        /// <summary>
        /// Constructor
        /// </summary>
        public Graph() {
            _edges = new List<Tuple<Node, Node>>();
        }

        /// <summary>
        /// Add an edge, and possible one or two nodes
        /// </summary>
        /// <param name="start">Edge start</param>
        /// <param name="end">Edge end</param>
        public void AddEdge(Node start, Node end) {
            _edges.Add(new Tuple<Node, Node>(start, end));
            _edges.Add(new Tuple<Node, Node>(end, start));
        }

        /// <summary>
        /// List of nodes connected to a node
        /// </summary>
        /// <param name="root">Root</param>
        /// <returns>List of connected nodes</returns>
        public List<Node> GetConnectedNodes(Node root) {
            return _edges.Where(edge => edge.Item1.Equals(root)).Select(edge => edge.Item2).ToList();
        }
    }

    /// <summary>
    /// Main program
    /// </summary>
    public static class Program {
        /// <summary>
        /// Verbose path
        /// </summary>
        private const bool Verbose = false;

        /// <summary>
        /// Indent for verbose path
        /// </summary>
        private static int _indent;

        /// <summary>
        /// Counts the number of paths from the start node to the end node
        /// </summary>
        /// <param name="graph">Graph</param>
        /// <param name="allowBonus">Allow a single bonus or not</param>
        /// <param name="current">Current node</param>
        /// <param name="visited">All the visited nodes</param>
        /// <param name="currentlyBonus">Current node is a bonus or not</param>
        /// <returns>Number of paths</returns>
        internal static int CountPaths(
            Graph graph,
            bool allowBonus = false,
            Node current = null,
            ISet<Node> visited = null,
            bool currentlyBonus = false
        ) {
            if (current == null) {
                current = graph.Start;
            }

            if (visited == null) {
                visited = new HashSet<Node>();
            }

            if (Verbose) {
                Console.WriteLine(new string(' ', _indent * 2) + current);
            }

            if (current.Equals(graph.End)) {
                return 1;
            }

            if (current.IsSmallCave() && !currentlyBonus) {
                visited.Add(current);
            }

            var count = 0;
            graph.GetConnectedNodes(current).ForEach(node => {
                _indent++;

                if (!visited.Contains(node)) {
                    count += CountPaths(graph, allowBonus, node, visited, false);
                } else if (allowBonus && !node.Equals(graph.Start)) {
                    count += CountPaths(graph, false, node, visited, true);
                }

                _indent--;
            });

            if (current.IsSmallCave() && !currentlyBonus) {
                visited.Remove(current);
            }

            return count;
        }

        /// <summary>
        /// Loads the graph from the given file
        /// </summary>
        /// <param name="filePath">File path</param>
        /// <returns>Graph loaded</returns>
        private static Graph LoadData(string filePath) {
            var graph = new Graph();

            foreach (var line in File.ReadLines(filePath)) {
                var elts = line.Split("-");
                graph.AddEdge(new Node(elts[0]), new Node(elts[1]));
            }

            return graph;
        }

        /// <summary>
        /// Main entry point
        /// </summary>
        /// <param name="args">Program arguments</param>
        public static void Main(string[] args) {
            var graph = LoadData(@"D:\GDrive\Programmation\AdventOfCode_2021\D12_CSharp\input");
            Console.WriteLine("Part 1:");
            Console.WriteLine(Part1.Run(graph));
            Console.WriteLine("Part 2:");
            Console.WriteLine(Part2.Run(graph));
            Console.WriteLine("OK");
        }
    }
}
