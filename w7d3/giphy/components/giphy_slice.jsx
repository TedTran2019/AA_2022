import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const fetchSearchGiphys = createAsyncThunk(
  'giphy',
  async (searchTerm) => {
    const response = await fetch(`http://api.giphy.com/v1/gifs/search?q=${searchTerm}&api_key=${process.env.GIPHY_KEY}&limit=2`)
    return response.json();
  }
)

export const giphySlice = createSlice({
  name: 'giphy',
  initialState: [],
  reducers: {},
  extraReducers: {
    [fetchSearchGiphys.fulfilled]: (state, action) => {
      state = action.payload.data;
      return state;
    }
  }
})

export const {} = giphySlice.actions;

export default giphySlice.reducer;
