module Notation.Additive

import Notation

import public Data.HVect
import public Data.Fun.Extra

infixl 8 .+., :+:, |+|, +., +:, +|, .+, :+, |+

public export
interface Additive1 a where
  constructor MkAdditive1
  O1    : 0 `ary` a
  (.+.) : 2 `ary` a

public export
interface Additive2 a where
  constructor MkAdditive2
  O2    : 0 `ary` a
  (:+:) : 2 `ary` a

public export
interface Additive3 a where
  constructor MkAdditive3
  O3    : 0 `ary` a
  (|+|) : 2 `ary` a

public export
interface AdditiveActsOn a b where
  constructor MkAdditiveActsOn
  (+.) : [a, b] `ary` b

public export
interface AdditiveActsOn2 a b where
  constructor MkAdditiveActsOn2
  (+:) : [a, b] `ary` b

public export
interface AdditiveActsOn3 a b where
  constructor MkAdditiveActsOn3
  (+|) : [a, b] `ary` b

public export
interface AdditiveActedBy a b where
  constructor MkAdditiveActedBy
  (.+) : [a, b] `ary` a

public export
interface AdditiveActedBy2 a b where
  constructor MkAdditiveActedBy2
  (:+) : [a, b] `ary` a

public export
interface AdditiveActedBy3 a b where
  constructor MkAdditiveActedBy3
  (|+) : [a, b] `ary` a

public export
Cast (HVect [0 `ary` a, 2 `ary` a]) (Additive1 a) where
  cast = uncurry MkAdditive1

public export
Cast (HVect [0 `ary` a, 2 `ary` a]) (Additive2 a) where
  cast = uncurry MkAdditive2 

public export
Cast (HVect [0 `ary` a, 2 `ary` a]) (Additive3 a) where
  cast = uncurry MkAdditive3

public export
Cast ([a,b] `ary` b) (AdditiveActsOn a b) where
  cast = MkAdditiveActsOn

public export
Cast ([a,b] `ary` b) (AdditiveActsOn2 a b) where
  cast = MkAdditiveActsOn2

public export
Cast ([a,b] `ary` b) (AdditiveActsOn3 a b) where
  cast = MkAdditiveActsOn3

public export
Cast ([a,b] `ary` a) (AdditiveActedBy a b) where
  cast = MkAdditiveActedBy

public export
Cast ([a,b] `ary` a) (AdditiveActedBy2 a b) where
  cast = MkAdditiveActedBy2

public export
Cast ([a,b] `ary` a) (AdditiveActedBy3 a b) where
  cast = MkAdditiveActedBy3
