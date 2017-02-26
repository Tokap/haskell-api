{-# LANGUAGE OverloadedStrings #-}

module Db where

import Control.Monad
import Database.MySQL.Simple
import Data.Word (Word16)
import qualified Data.Text as Text


data ConnectionDetails = ConnectionDetails {
  host :: String,
  port :: Word16,
  user :: String,
  pass :: String,
  db   :: String
}

data Status = Status {
  value :: String
}


myQuery :: Query
myQuery = "SELECT status FROM status_type"

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

stockQuery :: ConnectionDetails -> IO ()
stockQuery connDetails = do
  conn <- makeConnection connDetails
  xs <- query_ conn myQuery
  forM_ xs $ \(Only status) ->
    putStrLn $ Text.unpack "Status is: " ++ status


statusQuery :: ConnectionDetails -> IO [Status]
statusQuery connDetails = do
  conn <- makeConnection connDetails
  xs <- query_ conn myQuery

  return $ map (\(Only status) -> Status status) xs









-- STATIC CONFIG & WORKING:
-- stockQuery :: IO ()
-- stockQuery = do
--   let connDetails = defaultConnectInfo {
--                       connectHost     = "127.0.0.1",
--                       connectPort     = 3306,
--                       connectUser     = "root",
--                       connectPassword = "",
--                       connectDatabase = "ip_brolytics"
--                     }
--   conn <- connect connDetails
--   xs <- query_ conn myQuery
--   forM_ xs $ \(Only status) ->
--     putStrLn $ Text.unpack "Status is: " ++ status
