import { useState, useCallback } from 'react';

import Box from '@mui/material/Box';
import Link from '@mui/material/Link';
import Divider from '@mui/material/Divider';
import TextField from '@mui/material/TextField';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import LoadingButton from '@mui/lab/LoadingButton';
import InputAdornment from '@mui/material/InputAdornment';

import { useRouter } from 'src/routes/hooks';

import { Iconify } from 'src/components/iconify';

import axios from 'axios';

// ----------------------------------------------------------------------

export function SignUpView() {
  const router = useRouter();

  const [showPassword, setShowPassword] = useState(false);

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [category, setCategory] = useState('');
  const [address, setAddress] = useState('');
  const [gps, setGps] = useState('');
  const [status, setStatus] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const moveToSignIn = useCallback(() => {
    router.push('/sign-in');
  }, [router]);

  const handleSignUp = useCallback(async () => {
    setLoading(true);
    if (!email || !password || !name || !address || !gps) {
      setError('Please fill every field!');
      setLoading(false);
      return;
    }
    
    try {
      const response = await axios.post('/api/auth/signup', { email, password, name, address, gps});
      localStorage.setItem('token', response.data.token); 
      router.push('/sign-in'); 
    } catch (err) {
      setError('Error signing up, please try again!');
      setLoading(false);
    } 
  }, [email, password, name, address, gps, router]);

  const renderForm = (
    <Box display="flex" flexDirection="column" alignItems="flex-end">
      <TextField
        fullWidth
        name="email"
        label="Email address"
        placeholder="email@domain"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        InputLabelProps={{ shrink: true }}
        sx={{ mb: 3 }}
      />
      
      <TextField
        fullWidth
        name="password"
        label="Password"
        placeholder="password"
        InputLabelProps={{ shrink: true }}
        type={showPassword ? 'text' : 'password'}
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        InputProps={{
          endAdornment: (
            <InputAdornment position="end">
              <IconButton onClick={() => setShowPassword(!showPassword)} edge="end">
                <Iconify icon={showPassword ? 'solar:eye-bold' : 'solar:eye-closed-bold'} />
              </IconButton>
            </InputAdornment>
          ),
        }}
        sx={{ mb: 3 }}
      />

      <TextField
        fullWidth
        name="name"
        label="Company name"
        placeholder="Company Name"
        value={name}
        onChange={(e) => setName(e.target.value)}
        InputLabelProps={{ shrink: true }}
        sx={{ mb: 3 }}
      />

      <TextField
        fullWidth
        name="category"
        label="Category"
        placeholder="Category"
        value={category}
        onChange={(e) => setCategory(e.target.value)}
        InputLabelProps={{ shrink: true }}
        sx={{ mb: 3 }}
      />

      <TextField
        fullWidth
        name="address"
        label="Company address"
        placeholder="No, Street, District, City, Country."
        value={address}
        onChange={(e) => setAddress(e.target.value)}
        InputLabelProps={{ shrink: true }}
        sx={{ mb: 3 }}
      />

      <TextField
        fullWidth
        name="gps"
        label="Company GPS"
        placeholder="Latitude/Longitude"
        value={gps}
        onChange={(e) => setGps(e.target.value)}
        InputLabelProps={{ shrink: true }}
        sx={{ mb: 3 }}
      />

      {/** <TextField
        fullWidth
        name="status"
        label="Company status"
        placeholder="Company Status"
        value={status}
        onChange={(e) => setStatus(e.target.value)}
        InputLabelProps={{ shrink: true }}
        sx={{ mb: 3 }}
      /> */}

      <LoadingButton
        fullWidth
        size="large"
        type="submit"
        color="inherit"
        variant="contained"
        onClick={handleSignUp}
        loading={loading}
      >
        Sign up
      </LoadingButton>
    </Box>
  );

  return (
    <>
      <Box gap={1.5} display="flex" flexDirection="column" alignItems="center" sx={{ mb: 5 }}>
        <Typography variant="h5">Sign up</Typography>
        <Typography variant="body2" color="text.secondary">
          Already have an account?
          <Link 
            variant="subtitle2" sx={{ ml: 0.5 }}
            onClick={moveToSignIn}
          >
            Sign in
          </Link>
        </Typography>
      </Box>

      {renderForm}
    </>
  );
}
