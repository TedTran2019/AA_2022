import { connect } from 'react-redux';
import { allTodos } from '../../reducers/selectors';
import TodoList from './todo_list';
//connect API is outdated now, and so is separating Redux logic into folders by type
import { receiveTodo, removeTodo } from '../../actions/todo_actions';

const mapStateToProps = (state) => {
  return {
    todos: allTodos(state)
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    receiveTodo: todo => dispatch(receiveTodo(todo)),
    removeTodo: todo => dispatch(removeTodo(todo)),
    updateTodo: todo => dispatch(receiveTodo(todo))
  }
}

export default connect (
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

