import Alpine from "alpinejs";
import tasks from "./task-store";
import createTask from "./create-tasks";

export function initialize() {
  Alpine.store("tasks", tasks);
}

export function createTaskInit() {
  Alpine.store("createTask", createTask);
}
