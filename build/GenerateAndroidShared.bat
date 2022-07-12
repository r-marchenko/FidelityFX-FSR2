@echo off
setlocal enabledelayedexpansion

echo Checking pre-requisites... 

:: Check if CMake is installed
cmake --version > nul 2>&1
if %errorlevel% NEQ 0 (
    echo Cannot find path to cmake. Is CMake installed? Exiting...
    exit /b -1
) else (
    echo    CMake      - Ready.
) 

:: Check if Ninja is installed
ninja --version > nul 2>&1
if %errorlevel% NEQ 0 (
    echo Cannot find path to ninja. Is Ninja installed? Exiting...
    exit /b -1
) else (
    echo    Ninja      - Ready.
) 

:: Check if VULKAN_SDK is installed but don't bail out
if "%ANDROID_NDK%"=="" (
    echo Android NDK is not installed -Environment variable ANDROID_NDK is not defined- : Please install the latest Android NDK by using Andoid Studion or downloading from https://developer.android.com/ndk/downloads
) else (
    echo    Android NDK - Ready : %ANDROID_NDK%
)

mkdir android
cd android
cmake ../.. -G Ninja -DCMAKE_TOOLCHAIN_FILE="%ANDROID_NDK%/build/cmake/android.toolchain.cmake" -DGFX_API=VK -DFSR2_BUILD_AS_DLL=1
cd ..