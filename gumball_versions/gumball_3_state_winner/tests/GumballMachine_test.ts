import { assertEquals } from "@std/assert";
import { GumballMachine } from "../src/GumballMachine.ts";

// The machine prints with console.log (like the book's System.out.println), so to check what it
// printed, a test swaps console.log for a function that collects the lines, runs the action, then puts it back.
function printed(action: () => void): string[] {
  const lines: string[] = [];
  const original = console.log;
  console.log = (...args: unknown[]) => lines.push(args.join(" "));
  try {
    action();
  } finally {
    console.log = original;
  }
  return lines;
}

// Pass one of these to the machine to decide the 1-in-10 winner game
const alwaysWin = () => 0; // 0 * 10 -> 0, a winner
const neverWin = () => 0.5; // 0.5 * 10 -> 5, not a winner

Deno.test("a machine with gumballs starts waiting for a quarter", () => {
  const machine = new GumballMachine(2);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("an empty machine starts sold out", () => {
  const machine = new GumballMachine(0);
  assertEquals(machine.getState(), machine.getSoldOutState());
});

Deno.test("insert a quarter, then eject it", () => {
  const machine = new GumballMachine(2);
  assertEquals(printed(() => machine.insertQuarter()), ["You inserted a quarter"]);
  assertEquals(printed(() => machine.ejectQuarter()), ["Quarter returned"]);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("a loser gets one gumball", () => {
  const machine = new GumballMachine(5, neverWin);
  printed(() => machine.insertQuarter());
  assertEquals(printed(() => machine.turnCrank()), ["You turned...", "A gumball comes rolling out the slot..."]);
  assertEquals(machine.getCount(), 4);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("a winner gets two gumballs", () => {
  const machine = new GumballMachine(5, alwaysWin);
  printed(() => machine.insertQuarter());
  assertEquals(printed(() => machine.turnCrank()), [
    "You turned...",
    "A gumball comes rolling out the slot...",
    "A gumball comes rolling out the slot...",
    "YOU'RE A WINNER! You got two gumballs for your quarter",
  ]);
  assertEquals(machine.getCount(), 3);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("a winner who takes the last two gumballs sells the machine out", () => {
  const machine = new GumballMachine(2, alwaysWin);
  printed(() => machine.insertQuarter());
  printed(() => machine.turnCrank());
  assertEquals(machine.getCount(), 0);
  assertEquals(machine.getState(), machine.getSoldOutState());
});

Deno.test("you can't win with only one gumball left", () => {
  const machine = new GumballMachine(1, alwaysWin);
  printed(() => machine.insertQuarter());
  assertEquals(printed(() => machine.turnCrank()), [
    "You turned...",
    "A gumball comes rolling out the slot...",
    "Oops, out of gumballs!",
  ]);
  assertEquals(machine.getState(), machine.getSoldOutState());
});

Deno.test("refilling a sold out machine gets it going again", () => {
  const machine = new GumballMachine(0);
  printed(() => machine.refill(5));
  assertEquals(machine.getCount(), 5);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});
