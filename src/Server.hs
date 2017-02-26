{-# LANGUAGE OverloadedStrings #-}

module Server where

import Data.Monoid ((<>))
import Data.Aeson (FromJSON, ToJSON)
import Web.Scotty
import Control.Monad.IO.Class

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


----- POST JSON:
-- {
-- "userId": 5,
-- "id": 51,
-- "title":"A Title",
-- "body":"A body"
-- }

----- COMMENT JSON:
-- {
-- "postId": 5,
-- "name": "Terrible Terry Tate",
-- "email":"terry@tatemail.com",
-- "body":"A body"
-- }

startServer :: IO ()
startServer = do
  putStrLn "Starting Server on Port: 3000"

  scotty 3000 $ do

----------- GET REQ
    get "/hello/:name" $ do
      name <- param "name"
      text ("hello " <> name <> "!")

    get "/posts" $ do
      allPosts <- liftAndCatchIO $ getAllPosts myConnDetails :: ActionM [Post]
      json (allPosts :: [Post])

    get "/comments" $ do
      allComments <- liftAndCatchIO $ getAllComments myConnDetails :: ActionM [Comment]
      json (allComments :: [Comment])

    get "/comments/add" $ do
      comment <- liftAndCatchIO $ Req.getComment :: ActionM Comment
      json (comment :: Comment)


-------- POST REQ
    post "/posts" $ do
      newPost <- jsonData :: ActionM Post
      confSave <- liftAndCatchIO $ insertPost' myConnDetails newPost
      json newPost

    post "/comments" $ do
      newComment <- jsonData :: ActionM Comment
      confSave <- liftAndCatchIO $ insertComment myConnDetails newComment
      json newComment

    post "/posts/add" $ do
      newPost <- liftAndCatchIO $ Req.getPost :: ActionM Post
      confSave <- liftAndCatchIO $ insertPost' myConnDetails newPost
      json (newPost :: Post)

    post "/comments/add" $ do
      comment <- liftAndCatchIO $ Req.getComment :: ActionM Comment
      confSave <- liftAndCatchIO $ insertComment myConnDetails comment
      json (comment :: Comment)
