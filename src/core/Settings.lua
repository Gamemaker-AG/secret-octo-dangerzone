Settings = class("Settings")

function Settings:initialize()
    self.resolutions = {{1024, 576}, {1280, 720}, {1366, 768}, {1600, 900}, {1920, 1080}}
    self.settings = {
        resolution = {1366, 768},
        fullscreen = false,
        audio = 100,
        music = 100,
        mousespeed = 1,
    }
end