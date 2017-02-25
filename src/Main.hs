{-# LANGUAGE OverloadedStrings #-}
module Main where

import Server
import DataTypes (Post)
import Requests


-- import           Data.Aeson            (Value)
-- import qualified Data.ByteString.Char8 as S8
-- import qualified Data.Yaml             as Yaml
-- import           Network.HTTP.Simple

main :: IO ()
main = do
  post <- getPost
  print $ post



-- main = do
--   startServer
