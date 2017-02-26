{-# LANGUAGE OverloadedStrings #-}
module Main where

import Server
import Db

main :: IO ()
main = startServer





--------------------------------------------------------------------------------
--------------------------- Example Content ------------------------------------
--------------------------------------------------------------------------------
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
