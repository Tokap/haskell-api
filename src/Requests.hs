{-# LANGUAGE DuplicateRecordFields #-}

module Requests where

import           DataTypes
import           Data.Aeson
import           Network.HTTP.Simple


printFirstPost :: IO ()
printFirstPost = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/posts"
    response <- httpJSON request

    let postOutput = getResponseBody response :: [Post]
    print $ postOutput !! 0

printFirstComment :: IO ()
printFirstComment = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/comments"
    response <- httpJSON request

    let commentOutput = getResponseBody response :: [Comment]
    print $ commentOutput !! 0

getPost :: IO Post
getPost = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/posts/1"
    response <- httpJSON request

    let postOutput = getResponseBody response :: Post
    return postOutput

getComment :: IO Comment
getComment = do
    request <- parseRequest "GET https://jsonplaceholder.typicode.com/comments/1"
    response <- httpJSON request

    let commentOutput = getResponseBody response :: Comment
    return commentOutput
