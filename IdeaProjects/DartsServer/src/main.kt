fun main(args: Array<String>) {
    val settings = providerSettings()
    if (settings.getSettingsFromFile("E:\\providerSettings.txt")){
        print(settings.toStr())
        val provider = tDataProvider(settings)
        provider.addPort()
    }
}