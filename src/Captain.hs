{-# LANGUAGE OverloadedStrings #-}

module Captain
  ( AppConfig(..)
  , defaultConfig
  , app
  , appWith
  , main
  ) where

import Network.Wai (Middleware)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (addBase, staticPolicy)
import Web.Spock
import Web.Spock.Config

type AppM = SpockM () () () ()

newtype AppConfig = AppConfig
  { useLogger :: Bool
  }

{-| Sane base configuration for the web application in production.
-}
defaultConfig :: AppConfig
defaultConfig = AppConfig {useLogger = True}

{-| Run the web application.
-}
main :: IO ()
main = runSpock 4000 $ appWith defaultConfig

{-| The web application with default configuration.
-}
app :: IO Middleware
app = appWith defaultConfig

{-| The web application with injected configuration.
-}
appWith :: AppConfig -> IO Middleware
appWith config = do
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  spock spockCfg $ appStack config

appStack :: AppConfig -> AppM
appStack AppConfig {useLogger = True} = do
  middleware logStdoutDev
  middlewares
  routes
appStack _ = do
  middlewares
  routes

middlewares :: AppM
middlewares = middleware $ staticPolicy $ addBase "public"

routes :: AppM
routes = do
  get root $ text "Hello, Sailor!"
  get "about" $ text "About!"
