import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { getCSRFToken } from '../../utils/utils';
import { addUserErrors, clearUserErrors } from '../errors/errors_slice';
import { setLogin } from '../session/session_slice';

export const createUser = createAsyncThunk(
  'api/user/create',
  async (user, { dispatch, rejectWithValue }) => {
    try {
      const csrfToken = getCSRFToken();
      const response = await fetch('/api/user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(user)
      });
      if (response.ok) {
        const user = await response.json();
        dispatch(setLogin(user));
        dispatch(clearUserErrors());
        return user;
      } else {
        const errors = await response.json();
        dispatch(addUserErrors(errors));
        return rejectWithValue(errors);
      }
    } catch (error) {
      return rejectWithValue(error);
    }
  }
)

export const usersSlice = createSlice({
  name: 'users',
  initialState: {},
  reducers: {
    setUser: (state, action) => {
      state[action.payload.id] = action.payload;
    },
    clearUser: (state, action) => {
      state = {};
      return state;
    }
  },
  extraReducers: {
    [createUser.fulfilled]: (state, action) => {
      state[action.payload.id] = action.payload;
    },
  }
})

export const {setUser, clearUser} = usersSlice.actions;

export default usersSlice.reducer;
