{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-} -- Allows for multiple uses of data types
{-# LANGUAGE DeriveGeneric #-}

module DataTypes where
import Prelude hiding (id)

import Data.Monoid ((<>))
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import Web.Scotty hiding (body)

-------- Types are derived from the endpoints below:
-- https://jsonplaceholder.typicode.com/posts
-- https://jsonplaceholder.typicode.com/comments

--------------------------------------------------------------------------------
------------------------------------ POSTS -------------------------------------
--------------------------------------------------------------------------------

data Post = Post {
  userId :: Int,
  id     :: Int,
  title  :: String,
  body   :: String
} deriving (Show, Generic)
instance ToJSON Post
instance FromJSON Post

makePost :: String -> String -> Int -> Int -> Post
makePost title body userId pId = Post {
  userId = userId,
  id = pId,
  title = title,
  body = body
}

getPostUserId :: Post -> Int
getPostUserId post = userId (post :: Post)

getPostId :: Post -> Int
getPostId post = id (post :: Post)

getPostTitle :: Post -> String
getPostTitle post = title (post :: Post)

getPostBody :: Post -> String
getPostBody post = body (post :: Post)

--------------------------------------------------------------------------------
---------------------------------- COMMENTS ------------------------------------
--------------------------------------------------------------------------------
data Comment = Comment {
  postId :: Int,
  name   :: String,
  email  :: String,
  body   :: String
} deriving (Show, Generic)
instance ToJSON Comment
instance FromJSON Comment

makeComment :: String -> String -> String -> Int -> Comment
makeComment name email body pId = Comment {
  postId = pId,
  name = name,
  email = email,
  body = body
}

getCommentPostId :: Comment -> Int
getCommentPostId comment = postId (comment :: Comment)

getCommentName :: Comment -> String
getCommentName comment = name (comment :: Comment)

getCommentEmail :: Comment -> String
getCommentEmail comment = email (comment :: Comment)

getCommentBody :: Comment -> String
getCommentBody comment = body (comment :: Comment)
