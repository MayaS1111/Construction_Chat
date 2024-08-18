# Construction_Chat(BuiltBetter)

## Description
BuiltBetter is a user-friendly, real-time chat platform for construction workers and management teams.
- Multiple chats will be hosted within one construction project
- User's name, contact information, and job titles are displayed
- Job descriptions can be sent easily through chats


Deployed Site: [https://builtbetter.work](https://builtbetter.work)
Here is a test log in for the deployed site:
  - Email: testadmin1@gmail.com 
  - Password: admin1


## Table of Contents
- [ERB](#erb)
- [Visual Aid](#visual-aid)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [FAQ](#faq)
- [Technologies Used](#technologies-used)

## ERB
<img width="700" alt="Screen Shot 2024-08-17 at 8 38 26 PM" src="https://github.com/user-attachments/assets/9ba423cd-cb3c-4b23-a5ba-1e49b5232ac2">

## Visual Aid
<img width="700" alt="Project and Chat Page" src="https://github.com/user-attachments/assets/46b8711e-920c-466d-9a1f-876e5af18dfa">
<img width="700" alt="Chat Member List and Other Buttons" src="https://github.com/user-attachments/assets/5cf96ea6-4eac-49dc-86d3-6de4b3f2661b">
<img width="700" alt="User List" src="https://github.com/user-attachments/assets/ada9f230-e9f2-4e1d-9565-d9ae2706804c">
<img width="700" alt="User Profile" src="https://github.com/user-attachments/assets/ae7b9374-59df-48a9-8214-9865750ef34b">
<img width="700" alt="Admin Dashboard" src="https://github.com/user-attachments/assets/86794143-9f72-4656-8a7b-09bd5c095bb7">


## Installation

1. Clone the repository:
`git clone https://github.com/MayaS1111/Construction_Chat.git`

2. Navigate to the project directory:
`cd Construction_Chat`

3. Install the required gems:
`bundle install`

4. Set up the database:
`rails db:setup`

5. Start the server:
`bin/dev`

6. Add sample data:
`bundle exec rake sample_data`

After running the above commands you will have generated all the data needed to see the app functioning. You can sign in with:

Email: alice@example.com
Password: password

Or 

Email: adam@example.com
Password: password

Or make your own personal account by signing up!


## Usage
1. Start the server:
`bin/dev`

2. Open your browser and navigate to http://localhost:3000
Follow the on-screen instructions to use the application


## Contributing
Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request

## FAQ
### Ruby Version Errors
The project is written using Ruby 3.2.1, if you encounter issues upon cloning, make sure you have Ruby version 3.2.1 in your environment, also see the Ruby Language docs.

## Technologies Used 
- Ruby version: 3.2.1
- Rails version: 7.0.4.3
- Bootstrap 5.3.3
#### Core Gems
- gem 'rails', "~> 7.1.3", ">= 7.1.3.2"
- gem "sprockets-rails"
- gem "pg", "~> 1.1"
- gem "puma"
- gem "importmap-rails"
- gem "turbo-rails"
- gem "stimulus-rails"
- gem "jbuilder"
- gem "redis", "~> 4.0"
- gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
- gem "bootsnap", require: false
#### Frontend and Styles
- gem "sassc-rails"
#### Authentication and Authorization
- gem "devise"
###Admin Interface
- gem "rails_admin", "~> 3.0"
#### Development Tools
- gem "debug", platforms: %i[ mri mingw x64_mingw ]
- gem "web-console"
- gem "annotate"
- gem "better_errors"
- gem "binding_of_caller"
- gem "draft_generators"
- gem "grade_runner"
- gem "pry-rails"
- gem "rails_db"
- gem "rails-erd"
- gem "rufo"
- gem "specs_to_readme"
#### Testing
- gem "capybara"
- gem "selenium-webdriver"
- gem "webdrivers"
- gem "rspec-rails", "~> 6.0.0"
- gem "draft_matchers"
- gem "rspec-html-matchers"
- gem "webmock"

## Contact
- Maya Sheriff - [maysheriff2018@gmail.com](mailto:maysheriff2018@gmail.com)
- Project Link: [https://github.com/MayaS1111/Construction_Chat](https://github.com/MayaS1111/Construction_Chat)
- Deployed Site: [https://builtbetter.work](https://builtbetter.work)
