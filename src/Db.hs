{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE DeriveGeneric #-}

module Db where

import Control.Monad
import Database.MySQL.Simple
import Data.Word (Word16)
import Data.Int (Int64)

import DataTypes (
        Post
      , makePost
      , getPostTitle
      , getPostBody
      , getPostUserId
      , getPostId
      , Comment
      , makeComment
      , getCommentPostId
      , getCommentName
      , getCommentEmail
      , getCommentBody
      )

--------------------------------------------------------------------------------
-------------------------- CONNECTION POOL -------------------------------------
--------------------------------------------------------------------------------

data ConnectionDetails = ConnectionDetails {
  host :: String,
  port :: Word16,
  user :: String,
  pass :: String,
  db   :: String
}


makeConnection :: ConnectionDetails -> IO Connection
makeConnection connDetails = do
  let connectionInfo = defaultConnectInfo {
                      connectHost     = (host connDetails),
                      connectPort     = (port connDetails),
                      connectUser     = (user connDetails),
                      connectPassword = (pass connDetails),
                      connectDatabase = (db connDetails)
                    }
  conn <- connect connectionInfo
  return conn
--------------------------------------------------------------------------------
----------------------------------- POSTS --------------------------------------
--------------------------------------------------------------------------------

-- QUERIES:
allPostsQuery :: Query
allPostsQuery = "SELECT title,body,id,userId FROM post_table"

selectPostQuery :: Query
selectPostQuery = "SELECT title,body,id,userId FROM post_table WHERE id=?"

insertPostStatement :: Query
insertPostStatement = "INSERT into post_table (title,body,id,userId) VALUES (?,?,?,?)"

insertPostStatement' :: Query
insertPostStatement' = "INSERT into post_table (title,body,userId) VALUES (?,?,?)"


-- READ:
getAllPosts :: ConnectionDetails -> IO [Post]
getAllPosts connDetails = do
  conn <- makeConnection connDetails
  xs <- query_ conn allPostsQuery

  return $ map ( \(t, b, i, ui) -> makePost t b i ui) xs

getPostById :: ConnectionDetails -> Int -> IO [Post]
getPostById connDetails i = do
  conn <- makeConnection connDetails
  xs <- query conn selectPostQuery [(i :: Int)]

  return $ map ( \(t, b, i, ui) -> makePost t b i ui) xs


-- INSERT: (returns number of affected rows)
insertPost :: ConnectionDetails -> Post -> IO Int64
insertPost connDetails post = do
  conn <- makeConnection connDetails
  execute conn insertPostStatement (
      (getPostTitle post)  :: String
    , (getPostBody post)   :: String
    , (getPostId post)     :: Int
    , (getPostUserId post) :: Int
    )

insertPost' :: ConnectionDetails -> Post -> IO Int64
insertPost' connDetails post = do
  conn <- makeConnection connDetails
  execute conn insertPostStatement' (
      (getPostTitle post)  :: String
    , (getPostBody post)   :: String
    , (getPostUserId post) :: Int
    )

--------------------------------------------------------------------------------
----------------------------------- COMMENTS -----------------------------------
--------------------------------------------------------------------------------

-- QUERIES:
allCommentsQuery :: Query
allCommentsQuery = "SELECT name,email,body,postId FROM comment_table"

selectCommentQuery :: Query
selectCommentQuery = "SELECT name,email,body,postId FROM comment_table WHERE id=?"

insertCommentStatement :: Query
insertCommentStatement = "INSERT into comment_table (name,email,body,postId) VALUES (?,?,?,?)"


-- READ:
getAllComments :: ConnectionDetails -> IO [Comment]
getAllComments connDetails = do
  conn <- makeConnection connDetails
  xs <- query_ conn allCommentsQuery

  return $ map (\(n, e, b, pid) -> makeComment n e b pid) xs

getCommentById :: ConnectionDetails -> Int -> IO [Comment]
getCommentById connDetails i = do
  conn <- makeConnection connDetails
  xs <- query conn selectCommentQuery [(i :: Int)]

  return $ map (\(n, e, b, pid) -> makeComment n e b pid) xs


-- INSERT: (returns number of affected rows)
insertComment :: ConnectionDetails -> Comment -> IO Int64
insertComment connDetails comment = do
  conn <- makeConnection connDetails
  execute conn insertCommentStatement (
      (getCommentName comment)   :: String
    , (getCommentEmail comment)  :: String
    , (getCommentBody comment)   :: String
    , (getCommentPostId comment) :: Int
    )
