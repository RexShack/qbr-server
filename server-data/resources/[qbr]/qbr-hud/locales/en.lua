local Translations = {
    error = {
        
    },
    success = {
        
    },
    info = {
        getstress = "You are getting stressed",
        thirsty = "You are a bit thirsty",
        relaxing = "You Are Relaxing",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
