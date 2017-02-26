{-# LANGUAGE OverloadedStrings #-}
module Main where

import Server
import Db

main :: IO ()
main = do

  -- let connDetails = ConnectionDetails {
  --   host = "127.0.0.1",
  --   port = 3306,
  --   user = "root",
  --   pass = "",
  --   db   = "ip_brolytics"
  -- }
  --

  startServer
