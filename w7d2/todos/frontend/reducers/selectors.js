export const allTodos = (state) => Object.values(state.todos);
export const allSteps = (state) => Object.values(state.steps);

export const stepsByTodoId = (state, todoId) => {
  const steps = allSteps(state);
  const targetSteps = [];
  console.log(steps);
  console.log(targetSteps);
  steps.forEach(step => {
    if (step.todo_id === todoId) {
      return targetSteps.push(step);
    }
  })
  return targetSteps;
}
