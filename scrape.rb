require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
driver = Selenium::WebDriver.for(:chrome, options: options)
wait = Selenium::WebDriver::Wait.new(:timeout => 15)

def update_slack(balance)
  uri = URI(ENV['WEBHOOK'])
  response = Net::HTTP.post_form(uri, {payload: 
    { 
      text: "Hackland account balance: #{balance}",
      icon_emoji: "moneybag"
    }.to_json
  })

  puts response
end


driver.get('https://www.asb.co.nz/')

# Click login button
element = driver.find_element(css: '#outline > div:nth-child(1) > header > div > div.right-section > div > div.component.component-login > a')
element.click

# Login form
driver.find_element(css: '#dUsername').send_keys(ENV['ASBUSERNAME'])
driver.find_element(css: '#password').send_keys(ENV['ASBPASSWORD'])
driver.find_element(css: '#loginBtn').click

# Get bank account balance
element = wait.until { driver.find_element(css: '#DomesticAccounts12-3449-0228041 > table > tbody > tr > td:nth-child(3)') }

balance = element.text.strip

if ENV['WEBHOOK']
  update_slack(balance)
else
  puts balance
end

driver.quit