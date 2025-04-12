<?php

namespace App\Http\Controllers;

use App\Models\Medicine;
use App\Models\MedicineTimer;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class MedicineController extends Controller
{
    function MedicineCreate(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'name' => 'required|string|max:100',
                'pieces' => 'required|integer|min:0',
                'description' => 'nullable|string',
                'start_date' => 'required|date',
                'end_date' => 'required|date|after_or_equal:start_date',
                'timers' => 'required|array|min:1',
                'timers.*.label' => 'required|string|max:50',
                'timers.*.time' => 'required|date_format:H:i'
            ]);

            DB::beginTransaction();

            $user_id = Auth::id();
            $medicine = Medicine::create([
                'name' => $request->input('name'),
                'pieces' => $request->input('pieces'),
                'description' => $request->input('description'),
                'start_date' => $request->input('start_date'),
                'end_date' => $request->input('end_date'),
                'user_id' => $user_id
            ]);

            // Add timers for the medicine
            foreach($request->input('timers') as $timer) {
                MedicineTimer::create([
                    'medicine_id' => $medicine->id,
                    'label' => $timer['label'],
                    'time' => $timer['time']
                ]);
            }

            DB::commit();
            return response()->json(['status' => 'success', 'message' => "Medicine added successfully"]);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json(['status' => 'fail', 'message' => $e->getMessage()]);
        }
    }

    function MedicineList(Request $request): JsonResponse
    {
        try {
            $user_id = Auth::id();
            $medicines = Medicine::where('user_id', $user_id)
                ->with('timers')
                ->get();

            return response()->json(['status' => 'success', 'rows' => $medicines]);
        } catch (Exception $e) {
            return response()->json(['status' => 'fail', 'message' => $e->getMessage()]);
        }
    }

    function MedicineByID(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'id' => 'required|integer|min:1'
            ]);

            $medicine_id = $request->input('id');
            $user_id = Auth::id();

            $medicine = Medicine::where('id', $medicine_id)
                ->where('user_id', $user_id)
                ->with('timers')
                ->first();

            if (!$medicine) {
                return response()->json(['status' => 'fail', 'message' => 'Medicine not found']);
            }

            return response()->json(['status' => 'success', 'rows' => $medicine]);
        } catch (Exception $e) {
            return response()->json(['status' => 'fail', 'message' => $e->getMessage()]);
        }
    }

    function MedicineUpdate(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'id' => 'required|integer|min:1',
                'name' => 'required|string|max:100',
                'pieces' => 'required|integer|min:0',
                'description' => 'nullable|string',
                'start_date' => 'required|date',
                'end_date' => 'required|date|after_or_equal:start_date',
                'timers' => 'required|array|min:1',
                'timers.*.id' => 'nullable|integer', // Existing timer IDs
                'timers.*.label' => 'required|string|max:50',
                'timers.*.time' => 'required|date_format:H:i'
            ]);

            $medicine_id = $request->input('id');
            $user_id = Auth::id();

            $medicine = Medicine::where('id', $medicine_id)
                ->where('user_id', $user_id)
                ->first();

            if (!$medicine) {
                return response()->json(['status' => 'fail', 'message' => 'Medicine not found']);
            }

            DB::beginTransaction();

            // Update medicine details
            $medicine->update([
                'name' => $request->input('name'),
                'pieces' => $request->input('pieces'),
                'description' => $request->input('description'),
                'start_date' => $request->input('start_date'),
                'end_date' => $request->input('end_date'),
            ]);

            // Remove all existing timers
            MedicineTimer::where('medicine_id', $medicine_id)->delete();

            // Add updated timers
            foreach($request->input('timers') as $timer) {
                MedicineTimer::create([
                    'medicine_id' => $medicine_id,
                    'label' => $timer['label'],
                    'time' => $timer['time']
                ]);
            }

            DB::commit();
            return response()->json(['status' => 'success', 'message' => "Medicine updated successfully"]);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json(['status' => 'fail', 'message' => $e->getMessage()]);
        }
    }

    function MedicineDelete(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'id' => 'required|integer|min:1'
            ]);

            $medicine_id = $request->input('id');
            $user_id = Auth::id();

            $medicine = Medicine::where('id', $medicine_id)
                ->where('user_id', $user_id)
                ->first();

            if (!$medicine) {
                return response()->json(['status' => 'fail', 'message' => 'Medicine not found']);
            }

            // Timers will be automatically deleted due to the cascading delete in the migrations
            $medicine->delete();

            return response()->json(['status' => 'success', 'message' => "Medicine deleted successfully"]);
        } catch (Exception $e) {
            return response()->json(['status' => 'fail', 'message' => $e->getMessage()]);
        }
    }
}
