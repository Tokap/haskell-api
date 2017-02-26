{-# LANGUAGE DuplicateRecordFields #-}

module Requests where

import           DataTypes
import           Data.Aeson
import           Network.HTTP.Simple

--------------------------------------------------------------------------------
------------------------------------ POSTS -------------------------------------
--------------------------------------------------------------------------------

getPost :: IO Post
getPost = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/posts/1"
    response <- httpJSON request

    let postOutput = getResponseBody response :: Post
    return postOutput

getPosts :: IO [Post]
getPosts = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/posts"
    response <- httpJSON request

    let postOutput = getResponseBody response
    return postOutput

--------------------------------------------------------------------------------
---------------------------------- COMMENTS ------------------------------------
--------------------------------------------------------------------------------

getComment :: IO Comment
getComment = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/comments/1"
    response <- httpJSON request

    let commentOutput = getResponseBody response :: Comment
    return commentOutput

getComments :: IO [Comment]
getComments = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/comments"
    response <- httpJSON request

    let commentOutput = getResponseBody response
    return commentOutput
