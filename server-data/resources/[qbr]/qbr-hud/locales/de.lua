local Translations = {
    error = {
        
    },
    success = {
        
    },
    info = {
        getstress = "Du wirkst gestresst",
        thirsty = "Du wirkst ein wenig durstig",
        relaxing = "Du beruhigst dich",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
