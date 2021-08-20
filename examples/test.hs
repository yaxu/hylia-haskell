import Network.Hylia

import Foreign
import Foreign.Ptr
import Foreign.C.Types

main = alloca $
  \timeinfoPtr -> do hylia <- hylia_create
                     hylia_enable hylia (CBool 1)
                     hylia_process hylia 1 timeinfoPtr
                     timeinfo <- peek timeinfoPtr
                     putStrLn $ show timeinfo
                     hylia_set_beats_per_bar hylia (CDouble 3)
                     hylia_process hylia 1 timeinfoPtr
                     timeinfo <- peek timeinfoPtr
                     putStrLn $ show timeinfo
                     return ()
