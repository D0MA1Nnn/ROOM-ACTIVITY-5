import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
	const CalculatorScreen({super.key});

	@override
	State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
	final TextEditingController firstNumberController = TextEditingController();
	final TextEditingController secondNumberController = TextEditingController();
	String operation = '+';
	String result = '0';

	@override
	void dispose() {
		firstNumberController.dispose();
		secondNumberController.dispose();
		super.dispose();
	}

	void calculate() {
		final firstNumber = double.tryParse(firstNumberController.text);
		final secondNumber = double.tryParse(secondNumberController.text);

		if (firstNumber == null || secondNumber == null) {
			setState(() {
				result = 'Enter two valid numbers';
			});
			return;
		}

		final value = switch (operation) {
			'+' => firstNumber + secondNumber,
			'-' => firstNumber - secondNumber,
			'x' => firstNumber * secondNumber,
			'/' when secondNumber != 0 => firstNumber / secondNumber,
			_ => null,
		};

		setState(() {
			result = value?.toString() ?? 'Cannot divide by zero';
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Calculator'),
			),
			body: ListView(
				padding: const EdgeInsets.all(24),
				children: [
					TextField(
						controller: firstNumberController,
						keyboardType: const TextInputType.numberWithOptions(decimal: true),
						decoration: const InputDecoration(
							labelText: 'First number',
							border: OutlineInputBorder(),
						),
					),
					const SizedBox(height: 16),
					DropdownButtonFormField<String>(
						initialValue: operation,
						decoration: const InputDecoration(
							labelText: 'Operation',
							border: OutlineInputBorder(),
						),
						items: const [
							DropdownMenuItem(value: '+', child: Text('Add (+)')),
							DropdownMenuItem(value: '-', child: Text('Subtract (-)')),
							DropdownMenuItem(value: 'x', child: Text('Multiply (x)')),
							DropdownMenuItem(value: '/', child: Text('Divide (/)')),
						],
						onChanged: (value) {
							if (value != null) {
								setState(() {
									operation = value;
								});
							}
						},
					),
					const SizedBox(height: 16),
					TextField(
						controller: secondNumberController,
						keyboardType: const TextInputType.numberWithOptions(decimal: true),
						decoration: const InputDecoration(
							labelText: 'Second number',
							border: OutlineInputBorder(),
						),
					),
					const SizedBox(height: 24),
					FilledButton.icon(
						onPressed: calculate,
						icon: const Icon(Icons.calculate),
						label: const Text('Calculate'),
					),
					const SizedBox(height: 24),
					Text(
						'Result: $result',
						textAlign: TextAlign.center,
						style: const TextStyle(
							fontSize: 24,
							fontWeight: FontWeight.bold,
						),
					),
				],
			),
		);
	}
}
