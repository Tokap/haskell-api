{-# LANGUAGE OverloadedStrings #-}

module Server where

import Web.Scotty

import Db
import DataTypes (Post, Comment)
import Requests as Req


myConnDetails :: ConnectionDetails
myConnDetails = ConnectionDetails {
  host = "127.0.0.1",
  port = 3306,
  user = "root",
  pass = "",
  db   = "ip_brolytics"
}



startServer :: IO ()
startServer = do
  putStrLn "Starting Server on Port: 3000"

  scotty 3000 $ do
--------------------------------------------------------------------------------
---------------------------------- Get Reqs ------------------------------------
--------------------------------------------------------------------------------

    get "/posts" $ do
      allPosts <- liftAndCatchIO $ getAllPosts myConnDetails :: ActionM [Post]
      json (allPosts :: [Post])

    get "/comments" $ do
      allComments <- liftAndCatchIO $ getAllComments myConnDetails :: ActionM [Comment]
      json (allComments :: [Comment])

--------------------------------------------------------------------------------
---------------------------------- Post Reqs -----------------------------------
--------------------------------------------------------------------------------

--- COMMENTS:
    post "/comments" $ do
      newComment <- jsonData :: ActionM Comment
      confSave <- liftAndCatchIO $ insertComment myConnDetails newComment
      json newComment

    post "/comments/add" $ do
      comment <- liftAndCatchIO $ Req.getComment :: ActionM Comment
      confSave <- liftAndCatchIO $ insertComment myConnDetails comment
      json (comment :: Comment)

    post "/comments/add/alot" $ do
      newComments <- liftAndCatchIO $ Req.getComments :: ActionM [Comment]
      confSave <- liftAndCatchIO $ mapM (insertComment myConnDetails) newComments
      json (newComments :: [Comment])

--- POSTS:
    post "/posts" $ do
      newPost <- jsonData :: ActionM Post
      confSave <- liftAndCatchIO $ insertPost' myConnDetails newPost
      json newPost

    post "/posts/add" $ do
      newPost <- liftAndCatchIO $ Req.getPost :: ActionM Post
      confSave <- liftAndCatchIO $ insertPost' myConnDetails newPost
      json (newPost :: Post)

    post "/posts/add/alot" $ do
      newPosts <- liftAndCatchIO $ Req.getPosts :: ActionM [Post]
      confSave <- liftAndCatchIO $ mapM (insertPost' myConnDetails) newPosts
      json (newPosts :: [Post])
