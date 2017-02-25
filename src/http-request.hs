-- Example of a more complex https request
-- https://haskell-lang.org/library/http-client

{-# LANGUAGE OverloadedStrings #-}
import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.Yaml             as Yaml
import           Network.HTTP.Simple

main :: IO ()
main = do
    request' <- parseRequest "POST http://httpbin.org/post"
    let request
            = setRequestMethod "PUT"
            $ setRequestPath "/put"
            $ setRequestQueryString [("hello", Just "world")]
            $ setRequestBodyLBS "This is my request body"
            $ setRequestSecure True
            $ setRequestPort 443
            $ request'
    response <- httpJSON request

    putStrLn $ "The status code was: " ++
               show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)


------ ALTERNATE OPTIONS;
-- {-# LANGUAGE OverloadedStrings #-}
-- import           Data.Aeson            (Value)
-- import qualified Data.ByteString.Char8 as S8
-- import qualified Data.Yaml             as Yaml
-- import           Network.HTTP.Simple
--
-- main :: IO ()
-- main = do
--     let request
--             = setRequestPath "/get"
--             $ setRequestHost "httpbin.org"
--             $ defaultRequest
--     response <- httpJSON request
--
--     putStrLn $ "The status code was: " ++
--                show (getResponseStatusCode response)
--     print $ getResponseHeader "Content-Type" response
--     S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
