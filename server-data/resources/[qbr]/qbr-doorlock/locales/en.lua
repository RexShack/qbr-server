local Translations = {
    error = {
        nokey = "You do not have a key!",
    },
    success = { 
        
    },
    info = {
        unlocked = "unlocked",
        unlocking = "Unlocking",
        locking = "Locking",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
