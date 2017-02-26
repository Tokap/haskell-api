{-# LANGUAGE OverloadedStrings #-}
module Main where

import Server
import DataTypes (Post, makePost, makeComment)
import Requests
import Db


-- import           Data.Aeson            (Value)
-- import qualified Data.ByteString.Char8 as S8
-- import qualified Data.Yaml             as Yaml
-- import           Network.HTTP.Simple

main :: IO ()
main = do
  let connDetails = ConnectionDetails {
    host = "127.0.0.1",
    port = 3306,
    user = "root",
    pass = "",
    db   = "ip_brolytics"
  }

  let testPost = makePost "Generic Title" "Fleshed Out Post Body" 11 22
  let testComment = makeComment "Bill" "bill@bill.com" "A lot of words go here" 1
  -- statusQuery connDetails
  -- z <- getPostById connDetails 1
  z <- insertPost' connDetails testPost
  print $ z






  -- deets <- stockQuery' connDetails
  -- let deets = stockQuery' connDetails // This is bad: would make deets IO String
  -- putStrLn deets
