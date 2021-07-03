fun main(args: Array<String>) {
    val settings = ProviderSettings()
    if (settings.getSettingsFromFile("E:\\providerSettings.txt")){
        print(settings.toStr())
        val provider = DataProvider(settings)
        provider.addPort()
    }
}