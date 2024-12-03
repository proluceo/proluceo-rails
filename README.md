
# Proluceo - Ruby on Rails Frontend

This is the Ruby on Rails frontend for **Proluceo**, an open-source ERP system. It serves as the user-facing interface, offering a responsive and interactive experience powered by **TailwindCSS** and **Stimulus.js**.

## Features

- **Reactive Frontend**: Built with Stimulus.js to provide dynamic and interactive user experiences.
- **Modern Styling**: TailwindCSS is used for highly customizable, responsive, and modern UI components.
- **Rails-Powered**: Utilizes Rails' conventions for scalable and maintainable application development.
- **Open Source**: Fully open-source under the MIT License.

## Repository Structure

- `app/`: Core application code, including:
  - `controllers/`: Application controllers to handle user requests.
  - `views/`: HTML templates for rendering responses.
  - `models/`: ActiveRecord models for business data.
  - `javascript/`: Stimulus.js controllers and other JavaScript assets.
  - `assets/`: TailwindCSS styles and additional assets.

- `config/`: Configuration files for the Rails application.

- `db/`: Database migrations and schema.

- `public/`: Public-facing assets.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/proluceo-rails.git
   cd proluceo-rails
   ```

2. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

3. Set up the database:
   ```bash
   rails db:setup
   ```

4. Start the Rails server:
   ```bash
   rails server
   ```

5. Visit the application at `http://localhost:3000`.

## TailwindCSS and Stimulus.js Integration

- **TailwindCSS**: The application uses a custom TailwindCSS configuration for flexible and modern UI styling. Edit the configuration in `tailwind.config.js` as needed.
- **Stimulus.js**: Stimulus controllers are located in `app/javascript/controllers/`.

## Contributing

We welcome contributions! Please fork the repository, create a new branch for your feature or bugfix, and submit a pull request.

### Development Notes

- Use `bin/dev` to start the application in development mode with live reloading.
- Ensure all new features are covered by appropriate tests.

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

## Resources

- [Ruby on Rails Documentation](https://guides.rubyonrails.org/)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)
- [Stimulus.js Documentation](https://stimulus.hotwired.dev/)

## Contact

For questions or suggestions, please open an issue or reach out to the maintainers.

---

Thank you for contributing to Proluceo! Together, we're building the future of open-source ERP systems.
