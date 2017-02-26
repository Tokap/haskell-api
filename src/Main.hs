{-# LANGUAGE OverloadedStrings #-}
module Main where

import Server
import DataTypes (Post)
import Requests
import Db


-- import           Data.Aeson            (Value)
-- import qualified Data.ByteString.Char8 as S8
-- import qualified Data.Yaml             as Yaml
-- import           Network.HTTP.Simple

main :: IO [Status]
main = do
  let connDetails = ConnectionDetails {
    host = "127.0.0.1",
    port = 3306,
    user = "root",
    pass = "",
    db   = "ip_brolytics"
  }
  statusQuery connDetails






  -- deets <- stockQuery' connDetails
  -- let deets = stockQuery' connDetails // This is bad: would make deets IO String
  -- putStrLn deets
