||| Definitions and constructions involving free models
module Frex.Free
  
import Data.Setoid
import Frex.Signature
import Frex.Presentation
import Frex.Algebra
import Frex.Model

||| A model over a setoid `X` is a model that can also interpret the
||| elements of `X`.
|||
||| For example, the monads associated to a presentation are the
||| choices of a free model over each set(oid).
public export
record ModelOver (Pres : Presentation) (X : Setoid) where
  constructor MkModelOver  
  Model : Model Pres
  Env : X ~> cast Model
  
parameters {Pres : Presentation} {X : Setoid} (A, B : Pres `ModelOver` X)
  ||| States: Homomorphism between the models over X.
  public export 0
  PreservesEnv : (h : cast {to = Setoid} (A .Model) ~> cast (B .Model)) -> Type
  PreservesEnv h = (X ~~> cast (B .Model)).equivalence.relation
    (h . (A .Env))
         (B .Env)

||| A `Pres`-model over X homomorphism
public export
record (~>) {Pres : Presentation} {X : Setoid} (A, B : Pres `ModelOver` X) where
  constructor MkHomomorphism
  H : (A .Model) ~> (B .Model)
  preserves : PreservesEnv A B (H .H)

parameters {Pres : Presentation} {X : Setoid} (FX : Pres `ModelOver` X)
  ||| Weak initiality: for any other model over X there is a morphism from FX into it.
  public export 0
  Extender : Type
  Extender = (other : Pres `ModelOver` X) -> FX ~> other
  
  
  -- The following boilerplate lets us define a concrete `Extender` in stages.
  -- Were we to have co-pattern matching, we wouldn't need this boilerplate since we
  -- could define the various fields of Extender in stages
  
  public export 0
  ExtenderFunction : Type
  ExtenderFunction = ((other : Pres `ModelOver` X) -> (U $ FX .Model) -> (U other.Model))
  
  public export 0 
  ExtenderSetoidHomomorphism : Type
  ExtenderSetoidHomomorphism = ((other : Pres `ModelOver` X) -> 
    (cast {to = Setoid} $ FX .Model) ~> (cast other.Model))
  
  public export 0
  ExtenderAlgebraHomomorphism : Type
  ExtenderAlgebraHomomorphism = ((other : Pres `ModelOver` X) -> 
    (FX .Model) ~> (other.Model))
  
  ||| There's at most one homomorphism of models over X from FX
  public export 0
  Uniqueness : Type
  Uniqueness = (other : Pres `ModelOver` X) -> (extend1, extend2 : FX ~> other) ->
    (FX .Model ~~> other.Model).equivalence.relation
      extend1.H
      extend2.H
            
public export
record Freeness {Pres : Presentation} {X : Setoid} (FX : Pres `ModelOver` X) where
  constructor IsFree
  Exists : Extender FX
  Unique : Uniqueness FX
  
public export
record Free (Pres : Presentation) (X : Setoid) where
  constructor MkFree
  Data : Pres `ModelOver` X
  UP   : Freeness Data
