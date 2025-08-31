import { z } from "zod";

const TASKS_STORAGE_KEY = "simventory_tasks";

export const ItemsSchema = z.object({
  name: z.string(),
  id: z.string(),
  time_taken: z.number(),
  requirements: z.record(z.string(), z.number()),
  steps: z.number(),
  type: z.enum([
    "raw-material",
    "regional-raw-material",
    "commercial-product",
    "seasonal-product",
  ]),
  production: z.enum([
    "building-supplies-store",
    "car-parts",
    "coconut-farm",
    "donut-shop",
    "eco-shop",
    "factory",
    "farmers-market",
    "fashion-store",
    "fast-food-restaurant",
    "fish-marketplace",
    "fishery",
    "furniture-store",
    "gardening-supplies",
    "green-factory",
    "hardware-store",
    "home-appliances",
    "mulberry-grove",
    "oil-plant",
    "santas-workshop",
    "silk-store",
    "tropical-products-store",
  ]),
});

export interface Item extends z.infer<typeof ItemsSchema> {}

export interface Task {
  name: string;
  id: string;
  requirements: Record<string, number>;
  status: "todo" | "in-progress" | "done";
  priority?: "high" | "medium" | "low";
  type?: string;
  description?: string;
  duration?: number;
  rewards?: Array<{ itemId: string; quantity: number }>;
}

export interface BuildStep {
  item: Item;
  quantity: number;
  estimatedTime: number;
}

export interface BuildPlan {
  steps: BuildStep[];
  totalTime: number;
  optimalTime: number;
  missingItems: Array<{ item: Item; quantity: number }>;
}

export interface TaskStore {
  addTask: (task: Task) => void;
  removeTask: (taskId: string) => void;
  updateTask: (task: Task) => void;
  getTasks: () => Task[];
  timeTaken: (tasks: Task[]) => number;
  calculateBuildPlan: (task: Task) => BuildPlan;
  formatBuildTime: (seconds: number) => string;
  totalItemsRequired: (tasks: Task[]) => Record<string, number>;
}

export default {
  addTask(task: Task) {
    const tasks = this.getTasks();
    tasks.push(task);
    localStorage.setItem(TASKS_STORAGE_KEY, JSON.stringify(tasks));
  },
  removeTask(taskId: string) {
    const tasks = this.getTasks().filter((t) => t.id !== taskId);
    localStorage.setItem(TASKS_STORAGE_KEY, JSON.stringify(tasks));
  },
  updateTask(task: Task) {
    const tasks = this.getTasks().map((t) => (t.id === task.id ? task : t));
    localStorage.setItem(TASKS_STORAGE_KEY, JSON.stringify(tasks));
  },
  getTasks(): Task[] {
    const tasks = localStorage.getItem(TASKS_STORAGE_KEY);
    return tasks ? JSON.parse(tasks) : [];
  },
  totalItemsRequired(tasks: Task[]): Record<string, number> {
    const total: Record<string, number> = {};
    return total;
  },
  formatBuildTime(seconds: number): string {
    if (seconds < 60) {
      return `${seconds}s`;
    } else if (seconds < 3600) {
      const minutes = Math.floor(seconds / 60);
      const remainingSeconds = seconds % 60;
      return remainingSeconds > 0
        ? `${minutes}m ${remainingSeconds}s`
        : `${minutes}m`;
    } else {
      const hours = Math.floor(seconds / 3600);
      const remainingMinutes = Math.floor((seconds % 3600) / 60);
      return remainingMinutes > 0
        ? `${hours}h ${remainingMinutes}m`
        : `${hours}h`;
    }
  },
  calculateBuildPlan(task: Task): BuildPlan {
    // This is a simplified implementation
    // In a real app, this would calculate the production chain
    const steps: BuildStep[] = [];
    let totalTime = 0;
    const missingItems: Array<{ item: Item; quantity: number }> = [];

    // For now, just return empty plan
    return {
      steps,
      totalTime,
      optimalTime: totalTime,
      missingItems,
    };
  },
  timeTaken(tasks: Task[]): number {
    return tasks.reduce((total, task) => total + (task.duration || 0), 0);
  },
} as TaskStore;
