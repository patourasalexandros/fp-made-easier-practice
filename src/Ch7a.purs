module Ch7a where 

import Data.Eq (class Eq)
import Data.Generic.Rep (class Generic)
import Data.Ord (class Ord, Ordering(..), compare)
import Data.Show (class Show)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Console (log)
import Prelude (Unit, discard, show, ($), (<), (<=), (==), (>), (||))

data Maybe a = Nothing | Just a
derive instance eqMaybe :: Eq a => Eq (Maybe a)
derive instance ordMaybe :: Ord a => Ord (Maybe a)
derive instance genericMaybe :: Generic (Maybe a) _

instance showMaybe :: Show a => Show (Maybe a) where
  show = genericShow

data Either a b = Left a | Right b 
                         
type MyEitherVar = Either String (Maybe Int)

derive instance eqEither :: (Eq a,Eq b) => Eq (Either a b) 
derive instance ordEither :: (Ord a, Ord b) => Ord (Either a b)
derive instance genericEither :: Generic (Either a b) _
instance showEither :: (Show a, Show b) => Show (Either a b) where
  show = genericShow
                  
{-
  EQ Ord and Show
-}
{-
instance eqMaybe :: Eq a => Eq (Maybe a) where
  eq Nothing Nothing = true
  eq (Just x) (Just y) = x == y
  eq _ _ = false

instance ordMaybe :: Ord a => Ord (Maybe a) where
  compare Nothing Nothing = EQ
  compare (Just x) (Just y) = compare x y
  compare Nothing _ = LT
  compare _ Nothing = GT

instance showMaybe :: Show a => Show (Maybe a) where
  show Nothing = "Nothing"
  show (Just a) = "(Just " <> show a <> ")"
-}

greaterThanOrEq :: forall a . Ord a => a -> a -> Boolean
greaterThanOrEq x y = cmp == GT || cmp == EQ where cmp = compare x y

infixl 4 greaterThanOrEq as >=



test :: Effect Unit
test = do
  log $ show $ Just 5 == Just 5 -- COMPILER ERROR!! 
  log $ show $ Just 5 == Just 2 
  log $ show $ Just 5 == Nothing 
  log $ show $ Nothing == Just 5 
  log $ show $ Nothing == (Nothing :: Maybe Unit) 
  log "------------------" 
  log $ show $ Just 1 < Just 5 -- COMPILER ERROR!! 
  log $ show $ Just 5 <= Just 5 
  log $ show $ Just 5 > Just 10 
  log $ show $ Just 10 >= Just 10 
  log $ show $ Just 99 > Nothing 
  log $ show $ Just 99 < Nothing 
  log $ show $ Just "abc" 
  log $ show $ (Nothing :: Maybe Unit) 
  let x = Left "left" :: MyEitherVar
      y :: MyEitherVar
      y = Right $ Just 42
  log $ show $ x
  log $ show $ y


