{-# LANGUAGE ForeignFunctionInterface #-}

module Network.Hylia where

import Foreign
import Foreign.Ptr
import Foreign.C.String
import Foreign.C.Types

type Hylia = ()

data TimeInfo = TimeInfo { beatsPerBar :: CDouble,
                           beatsPerMinute :: CDouble,
                           beat :: CDouble,
                           phase :: CDouble,
                           playing :: CBool
                         }
                deriving Show

{-
typedef struct _hylia_time_info_t {
    double beatsPerBar, beatsPerMinute, beat, phase;
    bool playing;
} hylia_time_info_t;
-}

instance Storable TimeInfo where
  alignment _ = 8
  sizeOf _ = (40)
  peek ptr = do
    a <- (\hsc_ptr -> peekByteOff hsc_ptr 0) ptr
    b <- (\hsc_ptr -> peekByteOff hsc_ptr 8) ptr
    c <- (\hsc_ptr -> peekByteOff hsc_ptr 16) ptr
    d <- (\hsc_ptr -> peekByteOff hsc_ptr 24) ptr
    e <- (\hsc_ptr -> peekByteOff hsc_ptr 32) ptr
    return (TimeInfo a b c d e)
  poke ptr (TimeInfo a b c d e) = do
    (\hsc_ptr -> pokeByteOff hsc_ptr 0) ptr a
    (\hsc_ptr -> pokeByteOff hsc_ptr 8) ptr b
    (\hsc_ptr -> pokeByteOff hsc_ptr 16) ptr c
    (\hsc_ptr -> pokeByteOff hsc_ptr 24) ptr d
    (\hsc_ptr -> pokeByteOff hsc_ptr 32) ptr e

{-
hylia_t* hylia_create(void);
void hylia_enable(hylia_t* link, bool on);
void hylia_process(hylia_t* link, uint32_t frames, hylia_time_info_t* info);
void hylia_set_beats_per_bar(hylia_t* link, double beatsPerBar);
void hylia_set_beats_per_minute(hylia_t* link, double beatsPerMinute);
void hylia_set_output_latency(hylia_t* link, uint32_t latency);
void hylia_set_start_stop_sync_enabled(hylia_t* link, bool enabled);
void hylia_start_playing(hylia_t* link);
void hylia_stop_playing(hylia_t* link);
void hylia_cleanup(hylia_t* link);
-}

foreign import ccall unsafe "hylia.h hylia_create"
  hylia_create :: IO (Ptr Hylia)

foreign import ccall unsafe "hylia.h hylia_enable"
  hylia_enable :: Ptr Hylia -> CBool -> IO ()

foreign import ccall unsafe "hylia.h hylia_process"
  hylia_process :: Ptr Hylia -> CInt -> Ptr TimeInfo -> IO ()

foreign import ccall unsafe "hylia.h hylia_set_beats_per_bar"
  hylia_set_beats_per_bar :: Ptr Hylia -> CDouble -> IO ()

foreign import ccall unsafe "hylia.h hylia_set_beats_per_minute"
  hylia_set_beats_per_minute :: Ptr Hylia -> CDouble -> IO ()

foreign import ccall unsafe "hylia.h hylia_set_output_latency"
  hylia_set_output_latency :: Ptr Hylia -> CInt -> IO ()

foreign import ccall unsafe "hylia.h hylia_set_start_stop_sync_enabled"
  hylia_set_start_stop_sync_enabled :: Ptr Hylia -> CBool -> IO ()

foreign import ccall unsafe "hylia.h hylia_start_playing"
  hylia_start_playing :: Ptr Hylia -> IO ()

foreign import ccall unsafe "hylia.h hylia_stop_playing"
  hylia_stop_playing :: Ptr Hylia -> IO ()

foreign import ccall unsafe "hylia.h hylia_cleanup"
  hylia_cleanup :: Ptr Hylia -> IO ()

foreign import ccall unsafe "hylia.h hylia_beat_time"
  hylia_beat_time :: Ptr Hylia -> CDouble -> IO (CDouble)

