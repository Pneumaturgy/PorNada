# Testing with GUT

PorNada uses **GUT (Godot Unit Tests)** for quality assurance.

## Directory Structure
- **`res://Tests/`**: Contains all test scripts.
- **Unit Tests**: Focus on individual scripts (e.g., `entity.gd` math).
- **Integration Tests**: Focus on system interactions (e.g., Spawner + Alien logic).

## Running Tests
1. Enable the GUT plugin in Project Settings.
2. Open the **GUT Panel** at the bottom of the editor.
3. Configure the test directory to `res://Tests/`.
4. Click **Run All** to execute the test suite.

## Best Practices
- **Isolation**: Use `double` or `stub` for complex dependencies.
- **Assertions**: Always use appropriate assertions (`assert_eq`, `assert_true`, etc.).
- **Cleanup**: Ensure nodes are freed after tests to prevent memory leaks.

Refer to the [Official GUT Documentation](https://gut.readthedocs.io/en/latest/) for advanced usage.
