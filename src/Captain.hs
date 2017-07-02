{-# LANGUAGE OverloadedStrings #-}

module Captain
  ( main
  , app
  ) where

import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Web.Spock
import Web.Spock.Config

type AppM = SpockM () () () ()

main :: IO ()
main = do
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 4000 (spock spockCfg app)

app :: AppM
app = middlewares >> routes

middlewares :: AppM
middlewares = middleware logStdoutDev

routes :: AppM
routes = do
  get root $ text "Hello, Sailor!"
  get "about" $ text "About!"
