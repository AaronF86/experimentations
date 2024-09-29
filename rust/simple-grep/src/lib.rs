use std::error::Error;
use std::fs;
use std::sync::{Arc, Mutex};
use std::thread;

/// Configuration struct for the grep program.
pub struct Config {
    pub query: String,
    pub filename: String,
    pub concurrent: bool,
    pub count: bool,
}

impl Config {
    /// Constructs a new `Config`.
    ///
    /// # Arguments
    ///
    /// * `args` - A slice of command-line arguments.
    ///
    /// # Errors
    ///
    /// Returns a `Result` with a custom error message if arguments are missing or invalid.
    pub fn new(args: &[String]) -> Result<Config, &'static str> {
        if args.len() < 3 {
            return Err("not enough arguments");
        }

        let query = args[1].clone();
        let filename = args[2].clone();
        let concurrent = args.contains(&String::from("--concurrent"));
        let count = args.contains(&String::from("--count"));

        Ok(Config {
            query,
            filename,
            concurrent,
            count,
        })
    }
}

/// Runs the grep operation based on the configuration.
///
/// # Arguments
///
/// * `config` - A configuration object that controls how the grep operation is performed.
///
/// # Errors
///
/// If the file cannot be read or there are issues in threading, it returns an error.
pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string(config.filename)?;

    if config.concurrent {
        search_concurrent(&config.query, &contents, config.count)?;
    } else {
        search_sequential(&config.query, &contents, config.count)?;
    }

    Ok(())
}

/// Searches for the query string in a file sequentially and prints the results.
fn search_sequential(query: &str, contents: &str, count: bool) -> Result<(), Box<dyn Error>> {
    let mut matches = 0;

    for line in contents.lines() {
        if line.contains(query) {
            if !count {
                println!("{}", line);
            }
            matches += 1;
        }
    }

    if count {
        println!("Total matches: {}", matches);
    }

    Ok(())
}

/// Searches for the query string concurrently using multiple threads.
fn search_concurrent(query: &str, contents: &str, count: bool) -> Result<(), Box<dyn Error>> {
    let lines: Vec<String> = contents.lines().map(|line| line.to_string()).collect();
    let chunk_size = lines.len() / 4 + 1;  // split into 4 chunks for threads
    let query = Arc::new(query.to_string());

    let matches = Arc::new(Mutex::new(0));

    let mut handles = vec![];

    for chunk in lines.chunks(chunk_size) {
        let query = Arc::clone(&query);
        let matches = Arc::clone(&matches);
        let chunk = chunk.to_vec();

        let handle = thread::spawn(move || {
            let mut local_matches = 0;

            for line in chunk {
                if line.contains(&*query) {
                    if !count {
                        println!("{}", line);
                    }
                    local_matches += 1;
                }
            }

            let mut total = matches.lock().unwrap();
            *total += local_matches;
        });

        handles.push(handle);
    }

    for handle in handles {
        handle.join().map_err(|_| "Thread join failed")?;
    }

    if count {
        let total = matches.lock().unwrap();
        println!("Total matches: {}", total);
    }

    Ok(())
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sequential_search() {
        let query = "test";
        let contents = "\
Rust is a systems programming language.
It helps developers test their ideas quickly.
Testing is important in Rust.";

        let result = search_sequential(query, contents, false);
        assert!(result.is_ok());
    }

    #[test]
    fn test_concurrent_search() {
        let query = "test";
        let contents = "\
Rust is a systems programming language.
It helps developers test their ideas quickly.
Testing is important in Rust.";

        let result = search_concurrent(query, contents, false);
        assert!(result.is_ok());
    }

    #[test]
    fn test_no_matches() {
        let query = "notfound";
        let contents = "\
Rust is a systems programming language.
It helps developers test their ideas quickly.";

        let result = search_sequential(query, contents, false);
        assert!(result.is_ok());
    }
}
