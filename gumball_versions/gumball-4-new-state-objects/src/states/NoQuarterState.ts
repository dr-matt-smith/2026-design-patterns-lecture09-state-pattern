import { State } from "./State.ts";
import { HasQuarterState } from "./HasQuarterState.ts";
import { GumballMachine } from "../GumballMachine.ts";

export class NoQuarterState implements State {
    private machine: GumballMachine;

    constructor(machine: GumballMachine) {
        this.machine = machine;
    }

    public insertQuarter(): void {
        console.log("Changing from NO QUARTER to HAS QUARTER");
        const newState = new HasQuarterState(this.machine);
        this.machine.setState(newState);
    }

    public ejectQuarter(): void {
        console.log("invalid event");
    }

    public turnCrank(): void {
        console.log("invalid event");
    }

    public refill(): void {
        console.log("invalid event");
    }


    public entry(): void {
        console.log("(no actions for entry event)");
    }
    
    public toString(): string {
        return "NO QUARTER";
    }
}