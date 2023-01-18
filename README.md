### OpenAI-Demo
## What this project is all about?
In this project we will be exploring various models that Open AI provides , Image Generation, Text Completion and Code Completion. And we'll try to find different ways to use this in real life projects.

To start with the project you need to create your own OpenAI apiKey see reference [here](https://beta.openai.com/login/).

after creating you own apiKey you need to replace that key in the file name ``` AppLaunchController.swift ```

``` swift
class AppLaunchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating configurations
        let apiKey = "ADD YOUR OPENAI API KEY HERE"
        OpenAIWrapper.getInstance().createConfiguration(apiKey: apiKey)
        
        // launching home view controller
        let openAIWrapperInstance = OpenAIWrapper.getInstance()
        let vc = HomeViewController(_openAIWrapper: openAIWrapperInstance)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        self.present(navVC, animated: false)
        
    }
    
}

```

## Do you like my work? Go Spread a word!
Just give it a star ⭐️ and spread the word!

## Credits
**©** **Dheeraj kumar sharma** - *2023*
