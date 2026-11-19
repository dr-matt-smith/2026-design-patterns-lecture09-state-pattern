import { State } from "./State.ts";
import { NoQuarterState } from "./NoQuarterState.ts";
import { SoldState } from "./SoldState.ts";
import { GumballMachine } from "../GumballMachine.ts";

export class HasQuarterState implements State {
    private machine: GumballMachine;

    constructor(machine: GumballMachine) {
        this.machine = machine;
    }

    public insertQuarter(): void {
        console.log("invalid event");
    }

    public ejectQuarter(): void {
        console.log("Changing back to NO QUARTER");
        const newState = new NoQuarterState(this.machine);
        this.machine.setState(newState);
    }

    public turnCrank(): void {
        console.log("Changing to SOLD state");
        const newState = new SoldState(this.machine);
        this.machine.setState(newState);
    }

    public refill(): void {
        console.log("invalid event");
    }

    public entry(): void {
        console.log("(no actions for entry event)");
    }

    public toString(): string {
        return "HAS QUARTER";
    }
}