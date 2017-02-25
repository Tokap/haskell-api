{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-} -- Allows for multiple uses of data types
{-# LANGUAGE DeriveGeneric #-}

module DataTypes where

import Data.Monoid ((<>))
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import Web.Scotty

-- Example use:
-- data User = User { userId :: Int, userName :: String } deriving (Show, Generic)
-- instance ToJSON User
-- instance FromJSON User

-------- Types are derived from the endpoint below:
-- https://jsonplaceholder.typicode.com/posts/1

data Post = Post {
  userId :: Int,
  id     :: Int,
  title  :: String,
  body   :: String
} deriving (Show, Generic)
instance ToJSON Post
instance FromJSON Post


data Comment = Comment {
  postId :: Int,
  name   :: String,
  email  :: String,
  body   :: String
} deriving (Show, Generic)
instance ToJSON Comment
instance FromJSON Comment


data Address = Address {
  street  :: String,
  city    :: String,
  state    :: String,
  zipcode :: String
} deriving (Show, Generic)
instance ToJSON Address
instance FromJSON Address


data User = User {
  id       :: Int,
  name     :: String,
  username :: String,
  email    :: String,
  address  :: Address,
  phone    :: String
} deriving (Show, Generic)
instance ToJSON User
instance FromJSON User



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Incompatible with nested structure?
--
-- data Geo = Geo {
--   lat :: String,
--   lng :: String
-- } deriving (Show, Generic)
-- instance ToJSON Geo
-- instance FromJSON Geo
--
--
-- data Address = Address {
--   street  :: String,
--   suite   :: String,
--   city    :: String,
--   zipcode :: String,
--   geo     :: Geo
-- } deriving (Show, Generic)
-- instance ToJSON Address
-- instance FromJSON Address
--
--
-- data Company = Company {
--   name        :: String,
--   catchPhrase :: String,
--   bs          :: String
-- } deriving (Show, Generic)
-- instance ToJSON Company
-- instance FromJSON Company
--
-- data User = User {
--   id       :: Int,
--   name     :: String,
--   username :: String,
--   email    :: String,
--   address  :: Address,
--   phone    :: String,
--   website  :: String,
--   company  :: Company
-- } deriving (Show, Generic)
-- instance ToJSON User
-- instance FromJSON User
