{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE FlexibleInstances #-}

module Fgl.PatriciaTree
  (functions, mk)
where

import BenchGraph
import BenchGraph.GenericGraph (Edges)
import BenchGraph.Utils
import qualified BenchGraph.Suites as S

import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.PatriciaTree
import Data.Graph.Inductive.Query.DFS

instance GraphImpl UGr where
  mkGraph = mk

mk :: Edges -> UGr
mk e = mkUGraph (vertices e) e

functions :: [NSuite UGr]
functions =
  [ S.isEmpty isEmpty
  , S.edgeList edges
  , S.edgeCount size
  , S.vertexCount order
  , S.vertexList nodes
  , S.hasEdge (flip hasEdge) id
  , S.addVertex insNode (\x -> (x,()))
  , S.removeVertex delNode id
  , S.eq equal
  , S.addEdge insEdge (\(x,y) -> (x,y,()))
  , S.removeEdge delEdge id
  , S.context (&) (\(x,y) -> ([],x,(),[((),y)]))
  , S.dff dfs'
  , S.topSort topsort
  , S.reachable reachable id
  ]

