import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { clearSessionErrors, addSessionErrors } from '../errors/errors_slice';
import { getCSRFToken } from '../../utils/utils';
import { setUser, clearUser } from '../users/users_slice';

export const loginUser = createAsyncThunk(
  'api/session/login',
  async (user, { dispatch, rejectWithValue }) => {
    try {
      const csrfToken = getCSRFToken();
      const response = await fetch('/api/session', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(user)
      });
      if (response.ok) {
        const user = await response.json();
        dispatch(clearSessionErrors());
        dispatch(setUser(user));
        return user;
      } else {
        const errors = await response.json();
        dispatch(addSessionErrors(errors));
        return rejectWithValue(errors);
      }
    } catch (error) {
      return rejectWithValue(error);
    }
  }
)

export const logoutUser = createAsyncThunk(
  'api/session/logout',
  async ( arg, { dispatch, rejectWithValue }) => {
    try {
      const csrfToken = getCSRFToken();
      const response = await fetch('/api/session', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        }
      });
      if (response.ok) {
        const user = await response.json();
        dispatch(clearUser());
        return user;
      } else {
        const errors = await response.json();
        return rejectWithValue(errors);
      }
    } catch (error) {
      return rejectWithValue(error)
    }
  }
)

export const sessionSlice = createSlice({
  name: 'session',
  initialState: {
    id: null,
  },
  reducers: {
    setLogin: (state, action) => {
      state['id'] = action.payload.id;
    },
    setLogout: (state, action) => {
      state['id'] = null;
    }
  },
  extraReducers: {
    [loginUser.fulfilled]: (state, action) => {
      state['id'] = action.payload.id;
    },
    [logoutUser.fulfilled]: (state, action) => {
      state['id'] = null;
    },
  }
})

export const { setLogin, setLogout } = sessionSlice.actions;

export default sessionSlice.reducer;
