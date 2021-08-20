module Network.Hylia where

import Foreign
import Foreign.Ptr
import Foreign.C.Types

type Hylia = ()

foreign import ccall unsafe "hylia.h hylia_create"
  hylia_create :: IO Hylia

