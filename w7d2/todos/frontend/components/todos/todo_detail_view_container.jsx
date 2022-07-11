import { connect } from "react-redux";
import TodoDetailView from "./todo_detail_view";

const MapDispatchToProps = (dispatch) => {
  return {
    removeTodo: (todo) => dispatch(removeTodo(todo)),
    receiveSteps: (steps) => dispatch(receiveSteps(steps)),
  };
}

export default connect(null, mapDispatchToProps)(TodoDetailView);
