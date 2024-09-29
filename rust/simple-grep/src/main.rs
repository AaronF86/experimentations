use std::env;
use std::process;
use simple_grep::Config;

fn main() {
    // Parse command-line arguments
    let args: Vec<String> = env::args().collect();

    // Parse config
    let config = Config::new(&args).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {}", err);
        process::exit(1);
    });

    // Run the grep function
    if let Err(e) = simple_grep::run(config) {
        eprintln!("Application error: {}", e);
        process::exit(1);
    }
}
